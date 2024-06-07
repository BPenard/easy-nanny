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
    Prawn::Document.new(document_options) { |pdf| draw(pdf) }.render
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
    @last_measured_y = pdf.cursor

    paint
    add_logo

    write_text("Contrat de travail", title_options)
    write_text("Assistante Maternelle", subtitle_options)

    pdf.move_down @initialmove_y

    write_text("1. Parties du Contrat", section_title_options)
    write_text("Salariée : #{@nanny.full_name}, demeurant à #{@nanny.address}.", text_options)
    write_text("Employeur : #{@parent.full_name}, demeurant à #{@parent.address}.", text_options)

    reset_color
    print_header_and_footer
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
    @logopath         = "#{Rails.root}/app/assets/images/logo.png"
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
      @pdf.fill_color '800080'
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
