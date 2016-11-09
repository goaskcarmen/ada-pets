require 'test_helper'

class PetTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  def assert_validation model, fields, message
    refute model.valid?

    fields.each do |field|
      assert (model.errors.include? field.to_sym), "#{field} - #{message}"
      assert (model.errors[field.to_sym].include? message), "#{field} - #{message}"
    end

  end

  test "as_json works and provides the fields required" do
    pet = Pet.new(name: "Kylo", age: 14, human: "Kari")
    pet.save

    fields = %w(name age human id)

    fields.each do |field|
      assert_not_nil pet.as_json()[field]
    end
  end

  test "test required fields" do
    one_pet = Pet.new()
    # refute pet.valid?
    #refute is the same as assert_not

    assert_validation one_pet, %w(name human age), "can't be blank"
    # fields = %w(name age human)
    #
    # fields.each do |field|
    #   assert pet.errors.include? field.to_sym
    #   assert pet.errors[field.to_sym].include? "can't be blank"
    # end

    # this can be tested in the rails console by creating:
    #> bob = Pet.new
    #> bob.valid?
    #> bob.errors
  end
end
