extend view entity I_SALESORDERTP with
{
  @EndUserText.label: 'Beneficiary'
  @Semantics.text: true
  SALESORDER.ZZ_Beneficiary_SDH as ZZ_Beneficiary_SDH
  
}
