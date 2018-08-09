# encoding: UTF-8
# frozen_string_literal: true

class WelcomeController < ApplicationController
  layout 'berycoin'
  include Concerns::DisableCabinetUI

  def index
  end
end
