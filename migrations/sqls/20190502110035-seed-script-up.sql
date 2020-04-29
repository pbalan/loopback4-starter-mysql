/* Replace with your SQL commands */
USE `lbstarter`;

insert into roles
  (id, name, created_at, role_key, permissions)
  values
  (1, 'super_admin', now(), 1, '["ViewOwnUser","ViewAnyUser","ViewTenantUser","CreateAnyUser","CreateTenantUser","UpdateOwnUser","UpdateTenantUser","UpdateAnyUser","DeleteTenantUser","DeleteAnyUser","ViewTenant","CreateTenant","UpdateTenant","DeleteTenant","ViewRole","CreateRole","UpdateRole","DeleteRole","ViewAudit","CreateAudit","UpdateAudit","DeleteAudit"]');
insert into roles
  (id, name, created_at, role_key, permissions)
  values
  (2, 'admin', now(), 2, '["ViewOwnUser","ViewTenantUser","CreateTenantUser","UpdateOwnUser","UpdateTenantUser","DeleteTenantUser","ViewTenant","ViewRole"]');
insert into roles
  (id, name, created_at, role_key, permissions)
  values
  (3,'subscriber', now(), 3, '["ViewOwnUser","ViewTenant","ViewRole"]');

/* Password - test123!@# */
insert into users
  (id, first_name, last_name, username, password, email, mobile_number, created_at, default_tenant)
  values
  (1, 'Super', 'Admin', 'super_admin', '$2a$10$TOLMGK43MjbibS8Jap2RXeHl3.4sJcR3eFbms2dBll2LTMggSK9hG', 'super_admin@lbstarter.com','1234567890', now(), 1);

insert into tenants
  (id, name, type, created_at, created_by)
  values
  (1, 'application', 'application', now(), 1);

insert into user_tenants
  (user_id, tenant_id, created_at, role_id)
  values
  (1, 1, now(), 1);
