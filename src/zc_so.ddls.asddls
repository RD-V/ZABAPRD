@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption SO'
@Metadata.ignorePropagatedAnnotations: true
//@Search.searchable: true
@Metadata.allowExtensions: true

define root view entity ZC_SO 
  provider contract transactional_query
   as projection on ZI_SO as SalesOrder
{        
    key Soid,   
    Customerid,   
    Customername,
    Producttype,
    CreatedBy,
    CreatedAt,
    LastChangedBy,
    LastChangedAt,
    LocalLastChangedAt
}
