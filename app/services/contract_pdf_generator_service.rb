require 'open-uri'
require "prawn"
require "prawn/measurement_extensions"

class ContractPdfGeneratorService
  class WrongArgumentError < StandardError; end

  class << self
    def call(contract)
      new(contract).generate!
    end
  end

  def initialize(contract)
    @contract = contract
    @nanny    = contract.nanny
    @parent   = contract.parent
    @children = contract.children
    set_pdf_values
  end

  def generate!
    pdf = Prawn::Document.new(document_options) do |pdf|
      draw(pdf)
    end
    pdf.render_file("#{Rails.root}/tmp/ContratEasyNanny.pdf")
  end

  private

  def title_options
    {
      size: 24,
      align: :right,
      style: :semibold,
      move_down: 10
    }
  end

  def subtitle_options
    {
      size: 18,
      align: :right,
      style: :light,
      move_down: 10
    }
  end

  def section_title_options
    {
      size: 11,
      align: :left,
      style: :semibold,
      move_down: 10
    }
  end

  def text_options
    {
      size: 8,
      align: :left,
      style: :light,
      move_down: 4
    }
  end

  def draw(pdf)
    @pdf = pdf
    register_fonts
    @pdf.font("Quicksand")
    @last_measured_y = pdf.cursor

    paint
    add_logo

    write_text("Contrat de travail", title_options)
    write_text("Assistante Maternelle", subtitle_options)

    pdf.move_down @initialmove_y

    write_text("1. Parties du Contrat", section_title_options)
    write_text("Salariée : #{@nanny.full_name}, demeurant à #{@nanny.address}.", text_options)
    write_text("Employeur : #{@parent.full_name}, demeurant à #{@parent.address}.", text_options)
    write_text(" ")

    write_text("2. Objet du Contrat", section_title_options)
    write_text("Le présent contrat a pour objet l'emploi d'une assistante maternelle agréée pour la garde de", text_options)
      @contract.children.each do |child|
    write_text("#{child.first_name} #{child.last_name}", text_options)
      end
    write_text(" ")

    write_text("3. Durée et Horaire de Travail", section_title_options)
    write_text("Le contrat est conclu pour une durée de #{@contract.weekly_worked_hours} heures par mois, à compter du #{@contract.start_date}.
      Les horaires de travail sont les suivants
      Lundi : 9h - 18h
      Mardi : 9h - 18h
      Mercredi : 9h - 18h
      Jeudi : 9h - 18h
      Vendredi : 9h - 18h
      Samedi : 9h - 18h
      Dimanche : 9h - 18h", text_options)
    write_text(" ")

    write_text("4. Rémunération", section_title_options)

    write_text("La rémunération de l'assistante maternelle est fixée à #{@contract.gross_hourly_rate} euros par heure. Le salaire sera versé le #{@payment_date} de chaque mois.", text_options)
    write_text(" ")

    write_text("5. Congés", section_title_options)

    write_text("L'assistante maternelle a droit à 0 jours de congés payés par an :).", text_options)
    write_text(" ")

    write_text("6. Obligations de l'Employeur", section_title_options)
    write_text("L'employeur s'engage à fournir toutes les informations nécessaires à l'assistante maternelle concernant les habitudes de l'enfant et à assurer un environnement de travail sain et sécurisé.", text_options)
    write_text(" ")

    write_text("7. Obligations de l'Assistante Maternelle", section_title_options)
    write_text("L'assistante maternelle s'engage à assurer la garde de l'enfant dans le respect des horaires convenus et à signaler toute absence ou retard éventuel.", text_options)
    write_text(" ")

    write_text("8. Résiliation du Contrat", section_title_options)
    write_text("Le présent contrat peut être résilié par l'une ou l'autre des parties moyennant un préavis de 30 jours.", text_options)
    write_text(" ")

    write_text("9. Signatures", section_title_options)

    write_text("Fait à Paris, le #{@current_date}.", text_options)
    write_text("Employeur : ____________________________", text_options)
    write_text("Assistante Maternelle : ____________________________", text_options)
  end

  def register_fonts
    @pdf.font_families.update(
      "Quicksand" => {
        normal: "#{Rails.root}/app/assets/fonts/Quicksand-Regular.ttf",
        bold: "#{Rails.root}/app/assets/fonts/Quicksand-Bold.ttf",
        semibold: "#{Rails.root}/app/assets/fonts/Quicksand-SemiBold.ttf",
        italic: "#{Rails.root}/app/assets/fonts/Quicksand-Italic.ttf",
        light: "#{Rails.root}/app/assets/fonts/Quicksand-Light.ttf"
      },
      "Helvetica" => {
        normal: "#{Rails.root}/app/assets/fonts/Helvetica-Regular.ttf",
        bold: "#{Rails.root}/app/assets/fonts/Helvetica-Bold.ttf",
        italic: "#{Rails.root}/app/assets/fonts/Helvetica-Italic.ttf"
      }
    )
  end

  def write_text(text, options = {})
    @pdf.text text, options
    @pdf.move_down(options[:move_down]) if options[:move_down]
  end


  def set_pdf_values
    @layout           = :portrait
    @page_size        = 'A4'
    @margin_left      = 40.mm
    @margin_right     = 15.mm
    @margin_top       = 20.mm
    @margin_bottom    = 5.mm
    @logopath         = "#{Rails.root}/app/assets/images/logo2.png"
    @initial_y        = 50
    @initialmove_y    = 50
  end

  def document_options
    {
      page_layout: @layout,
      left_margin: @margin_left,
      right_margin:@margin_right,
      top_margin: @margin_top,
      bottom_margin: @margin_bottom,
      page_size: @page_size
    }
  end

  def paint
    @pdf.canvas do
      @pdf.fill_color "DEC8B3"
      @pdf.fill_polygon [@pdf.bounds.left, @pdf.bounds.top], [@pdf.bounds.left + 9.cm, @pdf.bounds.top], [@pdf.bounds.left, @pdf.bounds.top - 9.cm]
    end
    reset_color
  end

  def add_logo
    @pdf.image File.open(@logopath), width: 80, height: 80, at: [1.cm - @margin_left, 26.cm + @margin_top]
  end

  def reset_color
    @pdf.fill_color '000000'
  end

  def print_header_and_footer
    @pdf.page_count.times do |i|
      string = "#{@contract.pdf_name} - #{@parent.full_name} - #{@nanny.full_name} - #{i+1}/#{@pdf.page_count}"
      @pdf.go_to_page i+1
      @pdf.draw_text string, at: [ 7.mm - @margin_left, -3.mm], size: 6, style: :light
      next if i == 0

      @pdf.draw_text string, at: [ 7.mm - @margin_left, 282.mm], size: 6, style: :light
    end

    reset_color
  end
end
