# frozen_string_literal: true

class ApplicationController < ActionController::API
  include Pagy::Backend

  def pagy_metadata(pagy)
    {
      page: pagy.page,
      items: pagy.items,
      count: pagy.count,
      pages: pagy.pages,
      last: pagy.last,
      from: pagy.from,
      to: pagy.to,
      prev: pagy.prev,
      next: pagy.next,
    }
  end

end
