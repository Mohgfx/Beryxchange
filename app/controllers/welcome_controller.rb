class WelcomeController < ApplicationController
  layout 'listex'
  include Concerns::DisableCabinetUI

  def index
  end
end
