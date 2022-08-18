# class PhoneValidator < ActiveModel::Validator
#     def validate(record)
#         unless record.phone =~ /^[0-9]{10,10}*$/
#             record.errors.add :phone, "be Invalid. please!"
#         end
#     end
# end
class PhoneNumberValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      unless value =~ /^[0-9]{10,10}*$/
        record.errors[attribute] << (options[:message] || "is not an phone")
      end
    end
end