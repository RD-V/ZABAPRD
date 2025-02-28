@AccessControl.authorizationCheck: #CHECK
@EndUserText.label: '##GENERATED ZACONN1'
define root view entity ZR_ACONN1
  as select from zaconn1
{
  key id as ID,
  carrier_id as CarrierID,
  connection_id as ConnectionID,
  airport_from_id as AirportFromID,
  city_from as CityFrom,
  country_from as CountryFrom,
  @Semantics.user.createdBy: true
  local_created_by as LocalCreatedBy,
  @Semantics.systemDateTime.createdAt: true
  local_created_at as LocalCreatedAt,
  @Semantics.user.localInstanceLastChangedBy: true
  local_last_changed_by as LocalLastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
  
}
