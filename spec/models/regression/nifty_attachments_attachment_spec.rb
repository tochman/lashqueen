require 'rails_helper'

RSpec.describe Nifty::Attachments::Attachment do

  # === Relations ===
  it { is_expected.to belong_to :parent}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :parent_id }
	it { is_expected.to have_db_column :parent_type }
	it { is_expected.to have_db_column :token }
	it { is_expected.to have_db_column :digest }
	it { is_expected.to have_db_column :role }
	it { is_expected.to have_db_column :file_name }
	it { is_expected.to have_db_column :file_type }
	it { is_expected.to have_db_column :data }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :file_name }
	it { is_expected.to validate_presence_of :file_type }
	it { is_expected.to validate_presence_of :data }
	it { is_expected.to validate_presence_of :digest }
	#it { is_expected.to validate_presence_of :token }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end
