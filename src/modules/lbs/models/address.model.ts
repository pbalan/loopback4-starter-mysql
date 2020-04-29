import { model, property, belongsTo, Entity } from '@loopback/repository';

import { City, CityWithRelations } from './city.model';
import { State, StateWithRelations } from './state.model';
import { Country, CountryWithRelations } from './country.model';
import { AddressStatus } from '../status.enum';

@model({
  name: 'addresses',
})
export class Address extends Entity {
  @property({
    type: 'number',
    id: true,
  })
  id?: number;

  @property({
    type: 'string',
  })
  address1?: string;

  @property({
    type: 'string',
  })
  address2?: string;

  @property({
    type: 'string',
  })
  address3?: string;

  @property({
    type: 'string',
  })
  address4?: string;

  @belongsTo(
    () => City,
    { keyFrom: 'city_id', name: 'city_id' },
    {
      name: 'city_id',
    },
  )
  cityId?: number;

  @belongsTo(
    () => State,
    { keyFrom: 'state_id', name: 'state_id' },
    {
      name: 'state_id',
    },
  )
  stateId: number;

  @belongsTo(
    () => Country,
    { keyFrom: 'country_id', name: 'country_id' },
    {
      name: 'country_id',
    },
  )
  countryId?: number;

  @property({
    type: 'string',
  })
  zip?: string;

  @property({
    type: 'string',
  })
  status?: AddressStatus;

  constructor(data?: Partial<Address>) {
    super(data);
  }
}

export interface AddressRelations {
  country: CountryWithRelations;
  state: StateWithRelations;
  city: CityWithRelations;
}

export type AddressWithRelations = Address & AddressRelations;
