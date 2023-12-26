upload_file_rosa = function(path){

  # path = tar_read(data_rosa_dbase_file)

  excel_sheets = readxl::excel_sheets(path)

  index_data_sheets = c(
    "Overview", "1. Existing Research Projects", "2. Identified Research Needs"
    ,"3. References", "4. Definition of Terms", "5. Acronyms List", "6. Pivot Table"
  )

  #perfrom quick check 0 make sure sheet names are present and legit
  check_sheet_names = (excel_sheets %in% index_data_sheets) %>%  sum()

  stopifnot("Looks like the sheet names have changed\nplease inspect...." = check_sheet_names > 6)

  data_list = list(
    excel_sheets[excel_sheets %in% index_data_sheets]
    ,c(0, 1, 1, 1, 1, 1, 1)) %>%
    pmap(~{
      readxl::read_xlsx(path = path
                        ,sheet = .x
                        ,skip = .y)
    })

  return(data_list)

}
