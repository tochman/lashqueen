require 'rails_helper'

RSpec.describe Nifty::KeyValueStore::KeyValuePair do

  # === Relations ===
  it { is_expected.to belong_to :parent}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :parent_id }
	it { is_expected.to have_db_column :parent_type }
	it { is_expected.to have_db_column :group }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :value }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end