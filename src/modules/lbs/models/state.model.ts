import { model, property, belongsTo, Entity } from '@loopback/repository';
import { Language, LanguageWithRelations } from './language.model';

@model({
  name: 'states',
})
export class State extends Entity {
  @property({
    type: 'number',
    id: true,
  })
  id?: number;

  @property({
    type: 'string',
    name: 'name',
    required: true,
  })
  name?: string;

  @belongsTo(
    () => Language,
    { keyFrom: 'lang', name: 'lang' },
    {
      name: 'lang',
      required: true,
      default: 'en',
    },
  )
  lang?: string;

  @belongsTo(
    () => State,
    { keyFrom: 'state_en_id', name: 'state_en_id' },
    {
      name: 'state_en_id',
    },
  )
  stateEnId: number;

  constructor(data?: Partial<State>) {
    super(data);
  }
}

export interface StateRelations {
  language: LanguageWithRelations;
  state: StateWithRelations;
}

export type StateWithRelations = State & StateRelations;
