Sequel.migration do
  up do
    create_table(:schema_info) do
      Integer :version, null: false, default: 0
    end
  end

  down do
    drop_table(:schema_info)
  end
end
