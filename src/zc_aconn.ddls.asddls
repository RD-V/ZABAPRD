@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZI_ACONN'
define root view entity ZC_ACONN
  provider contract transactional_query
  as projection on ZI_ACONN
{
  key UUID,
  CarrierID,
  ConnectionID,
  AirportFromID,
  CityFrom,
  CountryFrom,
  LocalLastChangedAt
  
}
