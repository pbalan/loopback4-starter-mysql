import { DefaultCrudRepository } from '@loopback/repository';
import { Language, LanguageRelations } from '../models';
import { MysqlDataSource } from '../datasources';
import { inject } from '@loopback/core';

export class LanguageRepository extends DefaultCrudRepository<
  Language,
  typeof Language.prototype.id,
  LanguageRelations
  > {
  constructor(
    @inject('datasources.mysqldb') dataSource: MysqlDataSource,
  ) {
    super(Language, dataSource);
  }
}
