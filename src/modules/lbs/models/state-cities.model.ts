import { model, property, belongsTo, Entity } from '@loopback/repository';
import { State, StateWithRelations } from './state.model';
import { City, CityWithRelations } from './city.model';

@model({
  name: 'state_cities',
})
export class StateCities extends Entity {
  @property({
    type: 'number',
    id: true,
  })
  id?: number;

  @belongsTo(
    () => State,
    { keyFrom: 'state_en_id', name: 'state_en_id' },
    {
      name: 'state_en_id',
      required: true,
    },
  )
  stateEnId?: State;

  @belongsTo(
    () => City,
    { keyFrom: 'city_en_id', name: 'city_en_id' },
    {
      name: 'city_en_id',
      required: true,
    },
  )
  cityEnId?: number;

  constructor(data?: Partial<StateCities>) {
    super(data);
  }
}

export interface StateCitiesRelations {
  state: StateWithRelations;
  city: CityWithRelations;
}

export type StateCitiesWithRelations = StateCities & StateCitiesRelations;
