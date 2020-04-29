import { model, property, belongsTo, Entity } from '@loopback/repository';
import { Language, LanguageWithRelations } from './language.model';

@model({
  name: 'countries',
})
export class Country extends Entity {
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
    () => Country,
    { keyFrom: 'country_en_id', name: 'country_en_id' },
    {
      name: 'country_en_id',
    },
  )
  countryEnId: string;

  constructor(data?: Partial<Country>) {
    super(data);
  }
}

export interface CountryRelations {
  language: LanguageWithRelations,
  country: CountryWithRelations;
}

export type CountryWithRelations = Country & CountryRelations;
