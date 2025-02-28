//@AbapCatalog.sqlViewName: 'ZSV_SO'
//@AbapCatalog.compiler.compareFilter: true
//@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Interface SO'
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
//define root view ZI_SO as select from zsalesorder
define root view entity ZI_SO as select from zsalesorder
{
  key sales_order_id as Soid,
    customer_id as Customerid,
    customer_name as Customername ,
    product_type as Producttype,
    @Semantics.user.createdBy: true
    created_by as CreatedBy,
    @Semantics.systemDateTime.createdAt: true
    created_at as CreatedAt,
    @Semantics.user.lastChangedBy: true
    last_changed_by as LastChangedBy,
    @Semantics.systemDateTime.lastChangedAt: true
    last_changed_at as LastChangedAt,
    @Semantics.systemDateTime.localInstanceLastChangedAt: true
    locl_last_changed_at as LocalLastChangedAt 
}
