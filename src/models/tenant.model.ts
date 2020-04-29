import { model, property, belongsTo } from '@loopback/repository';

import { UserModifiableEntity } from './user-modifiable-entity.model';
import { TenantType } from '../modules/user-tenants/tenant-type.enum';
import { Address, AddressWithRelations } from '../modules/lbs/models/address.model';

@model({
  name: 'tenants',
})
export class Tenant extends UserModifiableEntity {
  @property({
    type: 'number',
    id: true,
  })
  id?: number;

  @property({
    type: 'string',
    required: true,
  })
  name: string;

  @property({
    type: 'string',
    required: true,
  })
  type: TenantType;

  @belongsTo(
    () => Address,
    { name: 'address_id' },
    {
      name: 'address_id',
    },
  )
  addressId?: number;

  @property({
    type: 'string',
    required: true,
    default: 'active',
  })
  status: string;

  constructor(data?: Partial<Tenant>) {
    super(data);
  }
}

export interface TenantRelations {
  address: AddressWithRelations;
}

export type TenantWithRelations = Tenant;
