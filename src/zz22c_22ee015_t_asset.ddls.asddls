@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'Zz2222ee015_AM'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZZ22C_22EE015_T_ASSET
  provider contract TRANSACTIONAL_QUERY
  as projection on ZZ22R_22EE015_T_ASSET
  association [1..1] to ZZ22R_22EE015_T_ASSET as _BaseEntity on $projection.ASSETID = _BaseEntity.ASSETID
{
  key AssetID,
  AssetName,
  Category,
  PurchaseDate,
  WarrantyEndDate,
  Status,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  _BaseEntity
}
