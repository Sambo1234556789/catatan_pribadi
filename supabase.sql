-- Jalankan sekali di Supabase: menu SQL Editor > New query > tempel > Run.

create table if not exists public.finance (
  user_id uuid primary key references auth.users(id) on delete cascade,
  data jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- Setiap pengguna hanya bisa membaca dan mengubah datanya sendiri.
alter table public.finance enable row level security;

create policy "baca data sendiri" on public.finance
  for select using ((select auth.uid()) = user_id);

create policy "tambah data sendiri" on public.finance
  for insert with check ((select auth.uid()) = user_id);

create policy "ubah data sendiri" on public.finance
  for update using ((select auth.uid()) = user_id)
  with check ((select auth.uid()) = user_id);

create policy "hapus data sendiri" on public.finance
  for delete using ((select auth.uid()) = user_id);
