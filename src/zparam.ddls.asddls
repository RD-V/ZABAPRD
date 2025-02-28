@AbapCatalog.sqlViewName: 'ZCDS_SALES'
@AbapCatalog.compiler.compareFilter: true
@AbapCatalog.preserveKey: true
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'param'
@Metadata.ignorePropagatedAnnotations: true
define view zparam 
with parameters  
    p_year : abap.char(4),
    p_formofaddress: abap.char(4)
    as select from I_BusinessPartnerVH as bp 
{
    key BusinessPartner,
    FormOfAddress,
    FormOfAddressName,
    BusinessPartnerName,
    BusinessPartnerCategory,
    BusinessPartnerIDByExtSystem,
    FirstName,
    LastName,
    OrganizationBPName1,
    GroupBusinessPartnerName1,
    BirthDate,
    AuthorizationGroup,
    IsBusinessPurposeCompleted,
    DataControllerSet,
    DataController1,
    DataController2,
    DataController3,
    DataController4,
    DataController5,
    DataController6,
    DataController7,
    DataController8,
    DataController9,
    DataController10,
    /* Associations */
    _FormOfAddressText
}
   where bp.BirthDate < :p_year and bp.FormOfAddress = :p_formofaddress
