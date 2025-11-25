select
  *
from
  (
    select
      pu.person_id,
      pu.username,
      ppn.full_name nome_completo,
      papf.person_number,
      (
        select
          pj.name
        from
          per_jobs pj
        where
          1 = 1
          and pj.job_id = pm.job_id
          and sysdate between pj.effective_start_date and pj.effective_end_date
      ) cargo,
      (
        select
          pj.approval_authority
        from
          per_jobs pj
        where
          1 = 1
          and pj.job_id = pm.job_id
          and sysdate between pj.effective_start_date and pj.effective_end_date
      ) nivel,
      (
        select
          pd.name
        from
          per_departments pd
        where
          pd.organization_id = pm.organization_id
          and sysdate between pd.effective_start_date and pd.effective_end_date
      ) departamento,
      (
        select
          ppn2.full_name
        from
          per_person_names_f ppn2
        where
          ppn2.person_id = px.supervisor_id
          and ppn2.name_type = 'BR'
          and sysdate between ppn2.effective_start_date and ppn2.effective_end_date
      ) supervisor,
      (
        select
          pj.approval_authority || ' - ' || pj.name
        from
          per_person_names_f ppn2,
          per_jobs pj,
          per_all_assignments_m pm2
        where
          ppn2.person_id = px.supervisor_id
          and ppn2.name_type = 'BR'
          and sysdate between ppn2.effective_start_date and ppn2.effective_end_date
          and pm2.person_id = ppn2.person_id
          and sysdate between pm2.effective_start_date and pm2.effective_end_date
          and pj.job_id = pm2.job_id
      ) cargo_supervisor,
      pu.active_flag ativo,
      pu.suspended,
      pm.grade_id,
      pm.job_id
    from
      per_person_names_f ppn,
      per_users pu,
      per_all_people_f papf,
      per_employees_x px,
      per_all_assignments_m pm
    where
      1 = 1
      and pu.person_id = ppn.person_id
      and sysdate between ppn.effective_start_date and ppn.effective_end_date
      and papf.person_id = ppn.person_id
      and sysdate between papf.effective_start_date and papf.effective_end_date
      and papf.person_id = pu.person_id
      and px.person_id = pu.person_id
      and pm.person_id = pu.person_id
      and pm.primary_flag = 'Y'
      and sysdate between pm.effective_start_date and pm.effective_end_date
      and ppn.name_type = 'BR'
      and pu.active_flag = 'Y'
      and pu.suspended = 'N'
      and sysdate between ppn.effective_start_date and ppn.effective_end_date 
      --and ppn.full_name like 'LUCAS%'
    order by
      ppn.full_name,
      pu.username asc
  ) x
where
  1 = 1 
  -- and x.full_name = 'GETULIO PEREIRA'
  -- and x.nome_completo like '%NATAN%'
  and x.departamento like '%LOGISTICA%'
order by
  x.supervisor
