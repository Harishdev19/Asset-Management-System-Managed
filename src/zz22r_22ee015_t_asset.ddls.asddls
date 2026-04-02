@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'Zz2222ee015_AM'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZZ22R_22EE015_T_ASSET
  as select from Z22EE015_T_ASSET
{
  key asset_id as AssetID,
  asset_name as AssetName,
  category as Category,
  purchase_date as PurchaseDate,
  warranty_end_date as WarrantyEndDate,
  status as Status,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt
}
