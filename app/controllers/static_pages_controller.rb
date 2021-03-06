class StaticPagesController < ApplicationController

  def feed
    @posts = Post.published.includes(:book).page params[:page]
    respond_to :rss
  end

  def search
    @query = params[:for]
    return redirect_to search_path if @query == ""
    @results = PgSearch
               .multisearch(@query)
               .includes(:searchable)
               .select("ts_headline(pg_search_documents.content, plainto_tsquery('english', ''' ' || '#{@query}' || ' ''' || ':*'), 'StartSel = {{, StopSel = }}, MaxWords = 20, MaxFragments = 2, FragmentDelimiter = ...') AS excerpt")
               .limit(10)
    # I want terms wrapped in <mark> tags, but I strip HTML
    # from excerpts so I mark terms as {{term}}, strip tags,
    # and then replace {{term}} with <mark>term</mark>
  end

end
