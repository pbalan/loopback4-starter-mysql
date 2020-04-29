import { inject } from '@loopback/core';

import { MysqlDataSource } from '../datasources';
import { Role } from '../models';
import { DefaultSoftCrudRepository } from './default-soft-crud.repository.base';

export class RoleRepository extends DefaultSoftCrudRepository<
  Role,
  typeof Role.prototype.id
  > {
  constructor(@inject('datasources.mysqldb') dataSource: MysqlDataSource) {
    super(Role, dataSource);
  }
}
