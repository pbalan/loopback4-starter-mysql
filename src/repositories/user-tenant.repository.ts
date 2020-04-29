import { Getter, inject } from '@loopback/core';
import { BelongsToAccessor, repository } from '@loopback/repository';

import { MysqlDataSource } from '../datasources';
import { Role, Tenant, User, UserTenant, UserTenantRelations } from '../models';
import { DefaultSoftCrudRepository } from './default-soft-crud.repository.base';
import { RoleRepository } from './role.repository';
import { TenantRepository } from './tenant.repository';
import { UserRepository } from './user.repository';

export class UserTenantRepository extends DefaultSoftCrudRepository<
  UserTenant,
  typeof UserTenant.prototype.id,
  UserTenantRelations
  > {
  public readonly tenant: BelongsToAccessor<
    Tenant,
    typeof UserTenant.prototype.id
  >;

  public readonly user: BelongsToAccessor<User, typeof UserTenant.prototype.id>;
  public readonly role: BelongsToAccessor<Role, typeof UserTenant.prototype.id>;

  constructor(
    @inject('datasources.mysqldb') dataSource: MysqlDataSource,
    @repository.getter(TenantRepository)
    tenantRepositoryGetter: Getter<TenantRepository>,
    @repository.getter(UserRepository)
    userRepositoryGetter: Getter<UserRepository>,
    @repository.getter(RoleRepository)
    roleRepositoryGetter: Getter<RoleRepository>,
    @repository(RoleRepository)
    public roleRepo: RoleRepository,
  ) {
    super(UserTenant, dataSource);

    this.tenant = this.createBelongsToAccessorFor(
      'tenant_id',
      tenantRepositoryGetter,
    );

    this.user = this.createBelongsToAccessorFor(
      'user_id',
      userRepositoryGetter,
    );

    this.role = this.createBelongsToAccessorFor(
      'role_id',
      roleRepositoryGetter,
    );
  }
}
