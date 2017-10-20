module ContactsHelper
  def choose_new_or_confirm
    if action_name == 'new' || action_name == 'confirm'
      confirm_contacts_path
    end
  end
end
