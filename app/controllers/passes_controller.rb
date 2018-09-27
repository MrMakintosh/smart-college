class PassesController < ApplicationController

  def index
    @department = Department.all
    @group = Group.first
    @student = @group.students.all
  end

  def add_pass
    @student = Student.find(params[:student])
    @pass_a = @student.passes.new
    @pass_n = @student.passes.new
    @pass_a.date_of_pass = Time.now
    @pass_n.date_of_pass = Time.now
    @pass_a.hours = params[:affirmative_hours]
    @pass_a.cause = "1"
    @pass_a.date_of = params[:date_of].to_date
    @pass_a.date_for = params[:date_for].to_date
    @pass_n.hours = params[:negative_hours]
    @pass_n.cause = "0"
    @pass_n.date_of = params[:date_of].to_date
    @pass_n.date_for = params[:date_for].to_date
    if @pass_a.save and @pass_n.save
      render :json => @student
    end
  end

  def api_request_main
    affirmative_first = 0
    negative_first = 0
    affirmative_second = 0
    negative_second = 0
    @group = Group.all
    passes_for_date = []
    study_year = []
    if (1..6).include? Time.now.month
      study_year.push Time.now.year - 1
      study_year.push Time.now.year
    elsif (9..12).include? Time.now.month
      study_year.push Time.now.year
      study_year.push Time.now.year + 1
    end
    @passes = Hash.new
    @group.each do |group|
      @passes["#{group.number}"] = Hash.new
      (9..12).each do |first_month|
        @passes["#{group.number}"]["#{first_month}"] = Hash.new
        @passes["#{group.number}"]["#{first_month}"]["first_half"] = Hash.new
        @passes["#{group.number}"]["#{first_month}"]["second_half"] = Hash.new
        group.students.each do |student|
          student.passes.each do |pass|
            if pass.date_of.month == "#{first_month}" and pass.date_for.month == "#{first_month}"
              if (1..15).include? pass.date_of.day and (1..15).include? pass.date_for.day
                if pass.cause == "1"
                  affirmative_first = affirmative_first + pass.hours
                else
                  negative_first = negative_first + pass.hours
                end
              elsif (16..31).include? pass.date_of.day and (16..31).include? pass.date_for.day
                if pass.cause == "1"
                  affirmative_second = affirmative_second + pass.hours
                else
                  negative_second = negative_second + pass.hours
                end
              end
            end
          end
          @passes["#{group.number}"]["#{first_month}"]["first_half"]["affirmative"] = affirmative_first
          @passes["#{group.number}"]["#{first_month}"]["first_half"]["negative"] = negative_first
          @passes["#{group.number}"]["#{first_month}"]["second_half"]["affirmative"] = affirmative_second
          @passes["#{group.number}"]["#{first_month}"]["second_half"]["negative"] = negative_second
          affirmative_first = 0
          negative_first = 0
          affirmative_second = 0
          negative_second = 0
        end
      end
      (1..6).each do |second_month|
        @passes["#{group.number}"]["#{second_month}"] = Hash.new
        @passes["#{group.number}"]["#{second_month}"]["first_half"] = Hash.new
        @passes["#{group.number}"]["#{second_month}"]["second_half"] = Hash.new
        group.students.each do |student|
          student.passes.each do |pass|
            if pass.date_of.month == "#{second_month}" and pass.date_for.month == "#{second_month}"
              if (1..15).include? pass.date_of.day and (1..15).include? pass.date_for.day
                if pass.cause == "1"
                  affirmative_first = affirmative_first + pass.hours
                else
                  negative_first = negative_first + pass.hours
                end
              elsif (16..31).include? pass.date_of.day and (16..31).include? pass.date_for.day
                if pass.cause == "1"
                  affirmative_second = affirmative_second + pass.hours
                else
                  negative_second = negative_second + pass.hours
                end
              end
            end
          end
          @passes["#{group.number}"]["#{second_month}"]["first_half"]["affirmative"] = affirmative_first
          @passes["#{group.number}"]["#{second_month}"]["first_half"]["negative"] = negative_first
          @passes["#{group.number}"]["#{second_month}"]["second_half"]["affirmative"] = affirmative_second
          @passes["#{group.number}"]["#{second_month}"]["second_half"]["negative"] = negative_second
          affirmative_first = 0
          negative_first = 0
          affirmative_second = 0
          negative_second = 0
        end
      end
    end
    render :json => @passes
  end

  private

  def pass_params
    params.require(:pass).permit(:hours, :lesson, :cause)
  end
end
