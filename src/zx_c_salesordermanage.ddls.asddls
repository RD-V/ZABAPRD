extend view entity C_SalesOrderManage with
{
  @EndUserText.label: 'Beneficiary'
  @Semantics.text: true
//  @UI.dataFieldDefault: [{hidden: false}]
//  @UI.identification: [{hidden: false}]
//  @UI.lineItem: [{hidden: false}]
  
  @UI.identification: [ { position: 20 } ]
  @UI.fieldGroup: [{ qualifier: 'OrderData', position: 20 }]
  @UI.lineItem: [ { position: 20 } ]
  @UI.selectionField: [ { position: 20 } ]

  @Consumption.valueHelpDefinition: [{ entity : {name: 'Z_I_BUSINESSPARTNERVH', element: 'BusinessPartner'  } }]
  SalesOrder.ZZ_Beneficiary_SDH as ZZ_Beneficiary_SDH
  
}
