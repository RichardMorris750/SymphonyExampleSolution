 
;  SYNERGY DATA LANGUAGE OUTPUT

 
;---------------------------------------------------------------------------------------------------- 
Structure BUYER   DBL ISAM
   Description "Buyer Master File"
 
Field BUYER_KEY   Type ALPHA   Size 32
   Description "record key; in essense a GUID"
   Required   Nonull
 
Field CREATED_TIMESTAMP   Type AUTOTIME   Size 8
   Description "Timestamp when record was created"
   Prompt "Created on:"   Readonly
   Nonull
 
Field MODIFIED_TIMESTAMP   Type AUTOTIME   Size 8
   Description "Timestamp when record was modified"
   Readonly
   Nonull
 
Field NAME   Type ALPHA   Size 30
   Description "Buyer Name"
   Prompt "Buyer Name"   Report Heading "Buyer Name"
   Break   Required
   Long Description
      "@CODEGEN_DISPLAY_FIELD"
 
Field ADDRESS1   Type ALPHA   Size 30
   Description "Address Line 1"
   Prompt "Address"   Report Heading "Address 1"
   Break   Required
 
Field ADDRESS2   Type ALPHA   Size 30
   Description "Address Line 2"
   Report Heading "Address 2"
 
Field ADDRESS3   Type ALPHA   Size 30
   Description "Address Line 3"
   Report Heading "Address 3"
 
Field POSTCODE   Type ALPHA   Size 10
   Description "Post Code"
   Prompt "Post Code"   Report Heading "Post Code"
   Break   Required
 
Field PHONE   Type ALPHA   Size 20
   Description "Phone Number"
   Prompt "Phone Number"   Report Heading "Phone Number"
 
Field MOBILE_PHONE   Type ALPHA   Size 20
   Description "Mobile Phone Number"
   Prompt "Mobile Phone Number"   Report Heading "Mobile Phone Number"
 
Field EMAIL   Type ALPHA   Size 50
   Description "Email Address"
   Prompt "Email Address"   Report Heading "Email Address"
 
Field FILLER   Type ALPHA   Size 500
   Description "Filler"
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "Primary Key - GUID"
   Segment FIELD   BUYER_KEY  SegType ALPHA  SegOrder ASCENDING
 
Key KEY02   ACCESS   Order ASCENDING   Dups NO
   Description "Alt key - created timestamp"
   Segment FIELD   CREATED_TIMESTAMP  SegType CTIMESTAMP  SegOrder ASCENDING
 
Key KEY03   ACCESS   Order ASCENDING   Dups NO
   Description "Alt key - modified timestamp"
   Segment FIELD   MODIFIED_TIMESTAMP  SegType TIMESTAMP  SegOrder ASCENDING
 
  
File BUYER   DBL ISAM   "SFEDATA:buyer.ism"
   Description "Buyer Master File"
   Assign BUYER

 ;----------------------------------------------------------------------------------------------
Structure ORDER_HEADER   DBL ISAM
   Description "Order Header"
 
Field ORDER_NO   Type DECIMAL   Size 6
   Description "Order No"
   Prompt "Order No"   Report Heading "Order No"
 
Field SUPP_CODE   Type ALPHA   Size 6
   Description "Supplier Code"
   Long Description
      "<SYMPHONY_ALPHA_SIZE=100>"
   Prompt "Supplier"   Report Heading "Supplier"
   Required
   Drill Method "SupplierCode"
 
Field ORDER_DATE   Type DATE   Size 8   Stored YYYYMMDD
   Description "Order date"
   Position 0 0   Prompt "Order Date"   Report Heading "Order Date"
   Required
 
Field REQD_DATE   Type DATE   Size 8   Stored YYYYMMDD
   Description "required delivery date"
   Prompt "Required by"   Report Heading "Required by"
   Required
 
Field COMMENTS   Type ALPHA   Size 40
   Description "Comments"
   Prompt "Comments"   Report Heading "Comments"
 
Field LINE_COUNT   Type DECIMAL   Size 5
   Description "Number of lines"
   Prompt "No of Lines"   Report Heading "No of Lines"
 
Field TOT_VALUE   Type DECIMAL   Size 10   Precision 2
   Description "Total Value (ex VAT)"
   Prompt "Total value (ex VAT)"   Report Heading "Total Value (Ex VAT)"
 
Field TOT_VAT   Type DECIMAL   Size 10   Precision 2
   Description "Total VAT"
   Prompt "Total VAT"   Report Heading "Total VAT"
 
Field TOT_QTY   Type DECIMAL   Size 6
   Description "Total Quantity"
   Prompt "Total Qty"   Report Heading "Total Quantity"
 
Field FILLER   Type ALPHA   Size 500   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "Priumary key - order no"
   Segment FIELD   ORDER_NO  SegType DECIMAL  SegOrder ASCENDING
 
Key KEY2   ACCESS   Order ASCENDING   Dups NO
   Description "2nd key - supplier code + order no"
   Segment FIELD   SUPP_CODE  SegType ALPHA  SegOrder ASCENDING
   Segment FIELD   ORDER_NO  SegType DECIMAL  SegOrder ASCENDING
 
Key KEY3   ACCESS   Order ASCENDING   Dups NO
   Description "order date + order"
   Segment FIELD   ORDER_DATE
   Segment FIELD   ORDER_NO
 
Key KEY4   ACCESS   Order ASCENDING   Dups NO
   Description "required date + order"
   Segment FIELD   REQD_DATE
   Segment FIELD   ORDER_NO

    
File ORDER_HEADER   DBL ISAM   "SFEDATA:order_header.ism"
   Description "Order Header File"
   Assign ORDER_HEADER
 
 ;-------------------------------------------------------------------------------------------


Structure ORDER_LINE   DBL ISAM
   Description "Order Line"
 
Field ORDER_NO   Type DECIMAL   Size 6
   Description "Order No"
   Prompt "Order No"   Report Heading "Order No"
 
Field LINE_NO   Type DECIMAL   Size 5
   Description "Line Seq No"
   Report Heading "Line Seq No"
 
Field PROD_CODE   Type ALPHA   Size 10
   Description "Product Code"
   Long Description
      "<SYMPHONY_ALPHA_SIZE=100>"
   Prompt "Product Code"   Report Heading "Product Code"
   Required
   Drill Method "ProductCode"
 
Field PROD_DESCRIPTION   Type ALPHA   Size 40
   Description "Description"
   Prompt "Description"   Report Heading "Description"
 
Field QTY   Type DECIMAL   Size 6
   Description "Quantity Ordered"
   Prompt "Quantity Ordered"   Report Heading "Quantity"
   Required
 
Field PRICE   Type DECIMAL   Size 8   Precision 2
   Description "Price"
   Position Relative 0 0   Prompt "Price"   Report Heading "Price"
 
Field LINE_VALUE   Type DECIMAL   Size 10   Precision 2
   Description "Line Value, excl VAT"
   Prompt "Line Value (ex VAT)"   Report Heading "Line Value"
 
Field VAT_RATE   Type DECIMAL   Size 5   Precision 2
   Description "VAT Rate"
   Prompt "VAT Rate"   Report Heading "VAT Rate"
 
Field VAT_VALUE   Type DECIMAL   Size 10   Precision 2
   Description "VAT Value"
   Position 0 0   Prompt "VAT Value"   Report Heading "VAT Value"
 
Field FILLER   Type ALPHA   Size 500   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "order number and line"
   Segment FIELD   ORDER_NO
   Segment FIELD   LINE_NO
 
Key PRODUCT   ACCESS   Order ASCENDING   Dups NO
   Description "product code"
   Segment FIELD   PROD_CODE
 
  
File ORDER_LINE   DBL ISAM   "SFEDATA:order_line.ism"
   Description "Order Line File"
   Assign ORDER_LINE

 ;--------------------------------------------------------------------------------------
Structure PARAMETER   RELATIVE
   Description "Parameter File"
 
Field LAST_ORDER_NO   Type DECIMAL   Size 6
   Description "Last Order Number"
   Report Heading "Last Order No"
 
Field FILLER   Type ALPHA   Size 594   Language Noview   Script Noview
   Report Heading "UNUSED"

    
File PARAMETER   RELATIVE   "SFEDATA:parameter.dat"
   Description "Parameter file"
   Assign PARAMETER
 
;---------------------------------------------------------------------------------------


Structure PRODUCT   DBL ISAM
   Description "Product Master File"
 
Field PROD_CODE   Type ALPHA   Size 6
   Prompt "Product Code"   Report Heading "Product Code"
   Uppercase
 
Field PROD_DESCRIPTION   Type ALPHA   Size 40
   Description "Description"
   Prompt "Description"   Report Heading "Description"
   Long Description
      "@CODEGEN_DISPLAY_FIELD"
 
Field SUPP_CODE   Type ALPHA   Size 6
   Description "Supplier Code"
   Long Description
      "<SYMPHONY_ALPHA_SIZE=100>"
   Prompt "Supplier"   Report Heading "Supplier"
   Uppercase
   Drill Method "SupplierCode"
 
Field COST_PRICE   Type DECIMAL   Size 8   Precision 2
   Description "Cost price"
   Prompt "Cost Price"   Report Heading "Cost Price"
 
Field SELL_PRICE   Type DECIMAL   Size 8   Precision 2
   Description "Selling Price"
   Prompt "Selling Price"   Report Heading "Selling Price"
 
Field PACK_SIZE   Type ALPHA   Size 10
   Description "Pack Size"
   Prompt "Pack Size"   Report Heading "Pack Size"
 
Field VAT_CODE   Type DECIMAL   Size 1
   Description "VAT Code"
   Prompt "VAT Code"   Report Heading "VAT Code"
   Selection List 0 0 0  Entries " 0.00%", "20.00%", " 5.00%", "EXEMPT"
   Enumerated 10 0 1
 
Field PROD_GROUP   Type ALPHA   Size 3
   Description "Product Group"
   Long Description
      "<SYMPHONY_ALPHA_SIZE=100>"
   Prompt "Product Group"   Report Heading "Product Group"
   Uppercase
   Drill Method "ProdGroup"
 
Field PROMOTION   Type DECIMAL   Size 1
   Description "On Promotion ? t/f"
   Prompt "On Offer ?"   Report Heading "On Offer ?"   Checkbox
 
Field FILLER   Type ALPHA   Size 500   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "Primary key - product code"
   Segment FIELD   PROD_CODE  SegType ALPHA  SegOrder ASCENDING

File PRODUCT   DBL ISAM   "SFEDATA:product.ism"
   Description "Product Master File"
   Assign PRODUCT
 

;-----------------------------------------------------------------------------------------
 
Structure PRODUCT_GROUP   DBL ISAM
   Description "Product Group"
 
Field PROD_GROUP   Type ALPHA   Size 3
   Description "Group Code"
   Prompt "Group Code"   Report Heading "Group Code"
   Uppercase
 
Field GROUP_DESC   Type ALPHA   Size 20
   Description "Group Description"
   Prompt "Description"   Report Heading "Description"
   Long Description
      "@CODEGEN_DISPLAY_FIELD"
 
Field FILLER   Type ALPHA   Size 500   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "Primary key - product group"
   Segment FIELD   PROD_GROUP  SegType ALPHA  SegOrder ASCENDING
 
  
 File PRODUCT_GROUP   DBL ISAM   "SFEDATA:product_group.ism"
   Description "Product Group master File"
   Assign PRODUCT_GROUP

;-------------------------------------------------------------------------------------------

Structure SELECTIONS   DBL ISAM
   Description "REeport selection fields"
 
Field START_SUPP   Type ALPHA   Size 6
   Description "Start Supplier"
   Prompt "First Supplier"   Report Heading "First Supplier"
   Uppercase
 
Field START_PROD   Type ALPHA   Size 6
   Description "Start Product Code"
   Prompt "Starting Product"   Report Heading "First Product"
   Uppercase
 
Field END_SUPP   Type ALPHA   Size 6
   Description "Last Supplier"
   Prompt "Last Supplier"   Report Heading "Last Supplier"
   Uppercase
 
Field END_PROD   Type ALPHA   Size 6
   Description "Ending product Code"
   Prompt "Last Product"   Report Heading "Last Product"
   Uppercase
 
Field KEYWORD   Type ALPHA   Size 20
   Description "Keyword"
   Long Description
      "<SYMPHONY_UPDATE_TRIGGER=PropertyChanged>"
   Prompt "Key Word"   Report Heading "Key Word"
 
Field REPORT_TYPE   Type ALPHA   Size 1
   Description "report type"
   Prompt "Report Type"   Report Heading "Report Type"
   Selection List 0 0 0  Entries "Report", "PDF"
 
Field KEYVALUE   Type ALPHA   Size 10
   Long Description
      "<SYMPHONY_UPDATE_TRIGGER=PropertyChanged>"
   Prompt "Key Value"   Report Heading "Key Value"

 

 ;--------------------------------------------------------------------------------------
Structure SUPPLIER   DBL ISAM
   Description "Supplier Master File"
 
Field SUPP_CODE   Type ALPHA   Size 6
   Description "Supplier Code"
   Prompt "Supplier Code"   Report Heading "Supplier Code"
   Uppercase
   Break   Required
 
Field NAME   Type ALPHA   Size 30
   Description "Supplier name"
   Prompt "Supplier Name"   Report Heading "Supplier Name"
   Break   Required
   Long Description
      "@CODEGEN_DISPLAY_FIELD"
 
Field ADDRESS1   Type ALPHA   Size 30
   Description "Address Line 1"
   Prompt "Address"   Report Heading "Address 1"
   Break   Required
 
Field ADDRESS2   Type ALPHA   Size 30
   Description "Address Line 2"
   Report Heading "Address 2"
 
Field ADDRESS3   Type ALPHA   Size 30
   Description "Address Line 3"
   Report Heading "Address 3"
 
Field POSTCODE   Type ALPHA   Size 10
   Description "Post Code"
   Prompt "Post Code"   Report Heading "Post Code"
   Break   Required
 
Field PHONE   Type ALPHA   Size 20
   Description "Phone Number"
   Prompt "Phone Number"   Report Heading "Phone No"
 
Field CONTACT   Type ALPHA   Size 30
   Description "Contact Name"
   Prompt "Contact Name"   Report Heading "Contact Name"
 
Field EMAIL   Type ALPHA   Size 50
   Description "Email Address"
   Prompt "Email Address"   Report Heading "Email"
 
Field CREATE_DATE   Type DATE   Size 8   Stored YYYYMMDD
   Prompt "Creation date"
   Date Today
 
Field ACCOUNT_STATUS   Type DECIMAL   Size 1
   Prompt "Account status"
   Default "1"
   Selection List 0 0 0  Entries "Active", "Dormant", "Closed"
   Enumerated 10 1 1
 
Field BUYER_KEY   Type ALPHA   Size 32
   Description "Buyer"
   Prompt "Buyer"   Report Heading "Buyer"
   Selection Window 0 0 "buyerLookup"
 
Field FLLER   Type ALPHA   Size 468   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "Primary key - supplier code"
   Segment FIELD   SUPP_CODE  SegType ALPHA  SegOrder ASCENDING

File SUPPLIER   DBL ISAM   "SFEDATA:supplier.ism"
   Description "Supplier Master File"
   Assign SUPPLIER
 

;-----------------------------------------------------------------------------------------
Structure CUSTOMER   DBL ISAM
   Description "Customer Master File"
 
Field CUST_CODE   Type DECIMAL   Size 6
   Description "Customer Code"
   Prompt "Customer Code"  
   Break   Required
 
Field NAME   Type ALPHA   Size 30
   Description "Supplier name"
   Prompt "Supplier Name"   Report Heading "Supplier Name"
   Break   Required
   Long Description
      "@CODEGEN_DISPLAY_FIELD"
 
Field ADDRESS1   Type ALPHA   Size 30
   Description "Address Line 1"
   Prompt "Address"   Report Heading "Address 1"
   Break   Required
 
Field ADDRESS2   Type ALPHA   Size 30
   Description "Address Line 2"
   Report Heading "Address 2"
 
Field ADDRESS3   Type ALPHA   Size 30
   Description "Address Line 3"
   Report Heading "Address 3"
 
Field POSTCODE   Type ALPHA   Size 10
   Description "Post Code"
   Prompt "Post Code"   Report Heading "Post Code"
   Break   Required
 
Field PHONE   Type ALPHA   Size 20
   Description "Phone Number"
   Prompt "Phone Number"   Report Heading "Phone No"
 
Field CONTACT   Type ALPHA   Size 30
   Description "Contact Name"
   Prompt "Contact Name"   Report Heading "Contact Name"
 
Field EMAIL   Type ALPHA   Size 50
   Description "Email Address"
   Prompt "Email Address"   Report Heading "Email"
 
Field CREATE_DATE   Type DATE   Size 8   Stored YYYYMMDD
   Prompt "Creation date"
   Date Today

Field FLLER   Type ALPHA   Size 468   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "Primary key - customer code"
   Segment FIELD   CUST_CODE  SegType DECIMAL  SegOrder ASCENDING
 
File CUSTOMER   DBL ISAM   "SFEDATA:customer.ism"
   Description "Customer Master File"
   Assign CUSTOMER


 ;----------------------------------------------------------------------------------------------
Structure SALES_ORDER_HEADER   DBL ISAM
   Description "Sales Order Header"
 
Field ORDER_NO   Type DECIMAL   Size 6
   Description "Order No"
   Prompt "Order No"   Report Heading "Order No"
 
Field CUST_CODE   Type DECIMAL   Size 6
   Description "Customer Code"
   Long Description
      "<SYMPHONY_ALPHA_SIZE=100>"
   Prompt "Customer"   Report Heading "Customer"
   Required
   Drill Method "CustomerCode"
 
Field ORDER_DATE   Type DATE   Size 8   Stored YYYYMMDD
   Description "Order date"
   Position 0 0   Prompt "Order Date"   Report Heading "Order Date"
   Required
 
Field REQD_DATE   Type DATE   Size 8   Stored YYYYMMDD
   Description "required delivery date"
   Prompt "Required by"   Report Heading "Required by"
   Required
 
Field COMMENTS   Type ALPHA   Size 40
   Description "Comments"
   Prompt "Comments"   Report Heading "Comments"
 
Field LINE_COUNT   Type DECIMAL   Size 5
   Description "Number of lines"
   Prompt "No of Lines"   Report Heading "No of Lines"
 
Field TOT_VALUE   Type DECIMAL   Size 10   Precision 2
   Description "Total Value (ex VAT)"
   Prompt "Total value (ex VAT)"   Report Heading "Total Value (Ex VAT)"
 
Field TOT_VAT   Type DECIMAL   Size 10   Precision 2
   Description "Total VAT"
   Prompt "Total VAT"   Report Heading "Total VAT"
 
Field TOT_QTY   Type DECIMAL   Size 6
   Description "Total Quantity"
   Prompt "Total Qty"   Report Heading "Total Quantity"
 
Field FILLER   Type ALPHA   Size 500   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "Primary key - order no"
   Segment FIELD   ORDER_NO  SegType DECIMAL  SegOrder ASCENDING
 
Key KEY2   ACCESS   Order ASCENDING   Dups NO
   Description "2nd key - customer code + order no"
   Segment FIELD   CUST_CODE  SegType DECIMAL  SegOrder ASCENDING
   Segment FIELD   ORDER_NO  SegType DECIMAL  SegOrder ASCENDING
 
Key KEY3   ACCESS   Order ASCENDING   Dups NO
   Description "order date + order"
   Segment FIELD   ORDER_DATE
   Segment FIELD   ORDER_NO
 
Key KEY4   ACCESS   Order ASCENDING   Dups NO
   Description "required date + order"
   Segment FIELD   REQD_DATE
   Segment FIELD   ORDER_NO
 
 File SALES_ORDER_HEADER   DBL ISAM   "SFEDATA:sales_order_header.ism"
   Description "Sales Order Header File"
   Assign SALES_ORDER_HEADER

 ;-------------------------------------------------------------------------------------------


Structure SALES_ORDER_LINE   DBL ISAM
   Description "Sales Order Line"
 
Field ORDER_NO   Type DECIMAL   Size 6
   Description "Order No"
   Prompt "Order No"   Report Heading "Order No"
 
Field LINE_NO   Type DECIMAL   Size 5
   Description "Line Seq No"
   Report Heading "Line Seq No"
 
Field PROD_CODE   Type ALPHA   Size 10
   Description "Product Code"
   Long Description
      "<SYMPHONY_ALPHA_SIZE=100>"
   Prompt "Product Code"   Report Heading "Product Code"
   Required
   Drill Method "ProductCode"
 
Field PROD_DESCRIPTION   Type ALPHA   Size 40
   Description "Description"
   Prompt "Description"   Report Heading "Description"
 
Field QTY   Type DECIMAL   Size 6
   Description "Quantity Ordered"
   Prompt "Quantity Ordered"   Report Heading "Quantity"
   Required
 
Field PRICE   Type DECIMAL   Size 8   Precision 2
   Description "Price"
   Position Relative 0 0   Prompt "Price"   Report Heading "Price"
 
Field LINE_VALUE   Type DECIMAL   Size 10   Precision 2
   Description "Line Value, excl VAT"
   Prompt "Line Value (ex VAT)"   Report Heading "Line Value"
 
Field VAT_RATE   Type DECIMAL   Size 5   Precision 2
   Description "VAT Rate"
   Prompt "VAT Rate"   Report Heading "VAT Rate"
 
Field VAT_VALUE   Type DECIMAL   Size 10   Precision 2
   Description "VAT Value"
   Position 0 0   Prompt "VAT Value"   Report Heading "VAT Value"
 
Field FILLER   Type ALPHA   Size 500   Language Noview   Script Noview
 
Key PRIMARY   ACCESS   Order ASCENDING   Dups NO
   Description "order number and line"
   Segment FIELD   ORDER_NO
   Segment FIELD   LINE_NO
 
Key PRODUCT   ACCESS   Order ASCENDING   Dups NO
   Description "product code"
   Segment FIELD   PROD_CODE

File SALES_ORDER_LINE   DBL ISAM   "SFEDATA:sales_order_line.ism"
   Description "Sales Order Line File"
   Assign SALES_ORDER_LINE



;----------------------------------------------------------------------------------------








