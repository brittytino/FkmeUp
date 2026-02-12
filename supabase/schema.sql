create extension if not exists "pgcrypto";

create table if not exists users (
  id uuid primary key default gen_random_uuid(),
  created_at timestamp with time zone default now()
);

create table if not exists tasks (
  id uuid primary key,
  user_id uuid references users(id) on delete cascade,
  title text not null,
  difficulty int not null,
  xp int not null,
  deadline timestamp with time zone,
  status text not null,
  created_at timestamp with time zone not null,
  completed_at timestamp with time zone,
  updated_at timestamp with time zone not null
);

create table if not exists daily_stats (
  user_id uuid references users(id) on delete cascade,
  date date not null,
  xp_earned int not null,
  tasks_completed int not null,
  updated_at timestamp with time zone not null,
  primary key (user_id, date)
);

create table if not exists streaks (
  user_id uuid primary key references users(id) on delete cascade,
  current_streak int not null,
  longest_streak int not null,
  last_completion_date date,
  grace_days_used int not null,
  updated_at timestamp with time zone not null
);

create table if not exists levels (
  user_id uuid primary key references users(id) on delete cascade,
  total_xp int not null,
  level int not null,
  xp_to_next_level int not null,
  updated_at timestamp with time zone not null
);

create index if not exists tasks_user_id_idx on tasks(user_id);
create index if not exists tasks_status_idx on tasks(status);
create index if not exists tasks_updated_at_idx on tasks(updated_at);
create index if not exists daily_stats_updated_at_idx on daily_stats(updated_at);
create index if not exists streaks_updated_at_idx on streaks(updated_at);
create index if not exists levels_updated_at_idx on levels(updated_at);

alter publication supabase_realtime add table tasks;
alter publication supabase_realtime add table daily_stats;
