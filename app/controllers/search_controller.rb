class SearchController < ApplicationController

  require "nokogiri"

  PAGE_SIZE = 20
  INDEX_NAME = 'main_index'

  class SearchResult
    attr_reader :model

    def initialize(model, controller)
      @model = model
      @controller = controller
    end

    def title
      unless @title
        @title =  case(@model)
                    when TextPage
                      @model.title && @model.title.size > 2 ? @model.title : @model.section.title
                    else
                      @model.title
                    end
      end
      @title
    end

    def description
      unless @description
        @description = if @model.respond_to? :description
                        @model.description
                       elsif @model.respond_to? :body 
                        n = Nokogiri::HTML(@model.body)
                        n.css('style,br').remove
                        n.text.strip.gsub(/\s+/, ' ')
                       end
      end
      @description
    end

    def path
      unless @path
        @path = case(@model)
                  when TextPage
                    @controller.text_page_path(@model)
                  else
                  '/'
                end
      end
      @path
    end

    def type
      unless @type
        @type = case(@model)
                  when TextPage
                   'search.types.pages'
                  else
                    'Undefined'
                end
      end
      @type
    end

    def section_chain
      unless @section_chain
        @section_chain = case(@model)
                           when TextPage
                            @model.section
                          else
                            nil
                         end
        @section_chain = @section_chain ? @section_chain.chain : []
      end
      @section_chain
    end
  end

  def search_words
    @page_number = [(params[:page] || '1').to_i, 1].max - 1
    @query = params['words'] || params['wordsline']
    @query = @query.to_s.strip
    @words = @query.split.select{|w| w.size > 2}.map(&:strip)
    @results = []
    if !@query || @query.size < 3 && @words.size == 0
      flash.now[:alert] = I18n.t('search.empty_request')
    elsif @words.size > 3
      flash.now[:alert] = I18n.t('search.more_word_request')
    else
      # array of SearchResult
      @results = []
      @results_by_type = {}

      translations = []
      words_query = @words.map{|w| w.to_s + '~0.9 OR ' + w.to_s + '*'}.map{|q| "(#{q})" }.join(' OR ')
      query = ['title', 'body', 'description'].map{|field| "#{field}_#{I18n.locale}:(#{words_query})"  }.join(' OR ')
      @translations_quantity, @translations = \
        ActsAsFerret.find_ids(query, INDEX_NAME, :limit => PAGE_SIZE, :offset => PAGE_SIZE * @page_number)
      @pages = (@translations_quantity.to_f / PAGE_SIZE).ceil

      if(@translations_quantity == 0)
        flash.now[:notice] = I18n.t('search.empty_result')
      else
        # всё хорошо
        @translations.each do |translation|
          model_class = eval(translation[:model])
          model = model_class.find(translation[:id]) rescue nil
          next unless model
          s = SearchResult.new(model, self)
          @results << s
          @results_by_type[s.type] = [] unless @results_by_type[s.type]
          @results_by_type[s.type] << s
        end
      end
    end
  end
end
