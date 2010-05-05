# don't mind me, I'm trying something new here
class SerializedAttributes < Module
  
  def initialize(column, *attributes)
    @column = column
    @attributes = attributes
  end
  
  
  # usually included is a class method, but now we are creating a module "insteance"
  def included(base)
    column = @column # needs to be local
    base.serialize column

    base.class_eval do
      define_method :"make_sure_#{column}_is_set" do
        send(:"#{column}=", send(column) || {})
      end
    end
    
    @attributes.each do |attribute|
      base.class_eval do
        define_method attribute do
          send :"make_sure_#{column}_is_set"
          send(column)[attribute]
        end

        define_method :"#{attribute}=" do |val|
          send :"make_sure_#{column}_is_set"
          if val.present? then
            send(column)[attribute] = val
          else
            send(column).delete(attribute)
          end
        end
      end
    end
  end
end