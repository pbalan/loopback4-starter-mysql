import { model, property, belongsTo, Entity } from '@loopback/repository';
import { Country, CountryWithRelations } from './country.model';
import { State, StateWithRelations } from './state.model';

@model({
  name: 'country_states',
})
export class CountryStates extends Entity {
  @property({
    type: 'number',
    id: true,
  })
  id?: number;

  @belongsTo(
    () => Country,
    { keyFrom: 'country_en_id', name: 'country_en_id' },
    {
      name: 'country_en_id',
      required: true,
    },
  )
  countryEnId?: number;

  @belongsTo(
    () => Country,
    { keyFrom: 'state_en_id', name: 'state_en_id' },
    {
      name: 'state_en_id',
      required: true,
    },
  )
  stateEnId?: number;

  constructor(data?: Partial<CountryStates>) {
    super(data);
  }
}

export interface CountryStatesRelations {
  country: CountryWithRelations;
  state: StateWithRelations;
}

export type CountryStatesWithRelations = CountryStates & CountryStatesRelations;
