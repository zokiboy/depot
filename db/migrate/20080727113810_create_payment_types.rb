class CreatePaymentTypes < ActiveRecord::Migration
  def self.up
    create_table :payment_types, :options => 'ENGINE=InnoDB DEFAULT CHARSET=utf8' do |t|
      t.column :label, :string, :null => false
      t.column :value, :string, :null => false
    end
 
    PaymentType.create(:label => 'Check' ,          :value => "check")
    PaymentType.create(:label => 'Credit Card' ,    :value => "cc")
    PaymentType.create(:label => 'Purchase Order' , :value => "po")
 
    remove_column :orders, :pay_type
 
    add_column :orders, :payment_type_id, :integer, {:null => false}
 
    execute "alter table orders add constraint fk_order_payment_types " <<
            "foreign key (payment_type_id) references payment_types(id)"
  end
 
  def self.down
    execute "alter table orders drop foreign key fk_order_payment_types"
    remove_column :orders, :payment_type_id
    add_column :orders, :pay_type, :string, :limit => 10
    drop_table :payment_types
  end

end
