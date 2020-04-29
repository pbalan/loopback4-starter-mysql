import { model, property, belongsTo, Entity } from '@loopback/repository';
import { Language, LanguageWithRelations } from './language.model';

@model({
  name: 'cities',
})
export class City extends Entity {
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
    () => City,
    { keyFrom: 'city_en_id', name: 'city_en_id' },
    {
      name: 'city_en_id',
    },
  )
  cityEnId: number;

  constructor(data?: Partial<City>) {
    super(data);
  }
}

export interface CityRelations {
  language: LanguageWithRelations;
  city: CityWithRelations;
}

export type CityWithRelations = City & CityRelations;
