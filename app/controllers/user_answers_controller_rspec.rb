class UserAnswersController < ApplicationController
  require 'rspec/core' unless defined? RSpec.configure
  require "rails_helper.rb"

  include RSpec::Matchers

  def create
    @drill = Drill.find params[:drill_id]
    correct_answers = @drill.answers
    correct = false
    correct_answers.each do |answer|
    # if answer.body.downcase == params[:user_answer].downcase
      # if expect(answer.body.downcase).to eq(params[:user_answer].downcase)
        # correct = true
      # end
    # end
      begin
        expect(answer.body.downcase).not_to eq(params[:user_answer].downcase)
      rescue Exception
        correct = true
      end
    end

    # if correct = true
    #
    #
    #
    # end

    render json: correct

  end
end
