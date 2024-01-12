class AfterSignUpController < ApplicationController
	include Wicked::Wizard
	steps :major
end
