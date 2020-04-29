import { model, property, Entity } from '@loopback/repository';

@model({
  name: 'languages',
})
export class Language extends Entity {
  @property({
    type: 'string',
    id: false,
    length: 2,
  })
  id?: string;

  @property({
    type: 'string',
    name: 'name',
  })
  name?: string;

  constructor(data?: Partial<Language>) {
    super(data);
  }
}

export interface LanguageRelations {
  // describe navigational properties here
}

export type LanguageWithRelations = Language & LanguageRelations;
