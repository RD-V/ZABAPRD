@Metadata.allowExtensions: true
@EndUserText.label: '###GENERATED Core Data Service Entity'
@AccessControl.authorizationCheck: #CHECK
define root view entity ZC_SV_CMPGRP
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_SV_CMPGRP
{
  key Id,
  CompanyId,
  CompanyName,
  LocalCreatedBy,
  LocalCreatedAt,
  LocalLastChangedBy,
  LocalLastChangedAt,
  LastChangedAt
  
}
