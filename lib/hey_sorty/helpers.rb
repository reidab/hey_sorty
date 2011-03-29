module HeySortyHelpers

  # Generates a link to sort the collection by the given column
  #
  # Options:
  #   - :label => The text of the link, defaults to the humanized version of the column name
  #   - :default_order => Direction to use when first sorting by this column, either :asc or :desc
  #   - :is_default =>  Specifies that the given column has been set as the default on the model, 
  #                     in order to properly assign the 'current' class on initial page load with
  #                     no params given. Can be set to :asc or :desc to match the direction specified
  #                     in the model.
  #
  def sorty(column, options = {})
    # Options
    options = { :label => column.to_s.humanize.titleize,
                :default_order => :asc }.merge(options)

    if options[:is_default] && params[:column].nil? && params[:order].nil?
      is_current = true
      current_order = options[:is_default]
    else
      is_current = params[:column].eql?(column.to_s)
      current_order = params[:order]
    end

    # Add params
    query = params.merge({
      :column => column,
      :order => is_current ? (current_order.to_s.eql?('asc') ? 'desc' : 'asc') : options[:default_order]
    })

    # Build new query string
    class_name = is_current ? "current #{query[:order]}" : options[:default_order]
    link_to(options[:label], query, :class => class_name)
  end
end

ActionView::Base.send(:include, HeySortyHelpers)
