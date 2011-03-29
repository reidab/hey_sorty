module HeySortyHelpers
  def sorty(column, options = {})
    # Options
    options = { :label => column.to_s.humanize.titleize }.merge(options)

    # Add params
    query = params.merge({
      :column => column,
      :order => params[:column].eql?(column.to_s) ? (params[:order].eql?('asc') ? 'desc' : 'asc') : 'asc'
    })

    # Build new query string
    class_name = params[:column].eql?(column.to_s) ? "current #{query[:order]}" : 'asc'
    link_to(options[:label], query, :class => class_name)
  end
end

ActionView::Base.send(:include, HeySortyHelpers)
