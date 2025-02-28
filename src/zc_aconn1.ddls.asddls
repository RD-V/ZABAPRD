@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.allowExtensions: true
@EndUserText.label: 'Projection View for ZR_ACONN1'
@ObjectModel.semanticKey: [ 'ID' ]
define root view entity ZC_ACONN1
  provider contract transactional_query
  as projection on ZR_ACONN1
{
  key ID,
      CarrierID,
      //@UI.selectionField: [{ position: 30 }]
      @Consumption.filter.selectionType: #RANGE
     // @
      ConnectionID,
      AirportFromID,
      CityFrom,
      CountryFrom,
      LocalLastChangedAt

}
