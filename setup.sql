-- ============================================================
-- XACE IA Search : à coller dans Supabase > SQL Editor > Run
-- ============================================================

create table if not exists public.posts (
  id uuid primary key default gen_random_uuid(),
  type text not null check (type in ('emploi','produit','savoir','pub')),
  titre text not null check (char_length(titre) between 3 and 120),
  description text not null check (char_length(description) between 10 and 2000),
  categorie text not null default 'Divers' check (char_length(categorie) <= 40),
  ville text check (char_length(ville) <= 40),
  prix integer check (prix is null or prix >= 0),
  contact text check (contact is null or char_length(contact) <= 20),
  vues integer not null default 0,
  approved boolean not null default false,
  created_at timestamptz not null default now()
);

alter table public.posts enable row level security;

-- Tout le monde voit seulement les publications validées
create policy "lecture validees" on public.posts
  for select using (approved = true);

-- Tout le monde peut publier, mais la publication attend votre validation
create policy "publier en attente" on public.posts
  for insert to anon, authenticated
  with check (approved = false and vues = 0);

-- Compteur de vues (appelé par l'application)
create or replace function public.ajouter_vue(pid uuid) returns void
language sql security definer set search_path = public as $$
  update public.posts set vues = vues + 1 where id = pid and approved = true;
$$;
grant execute on function public.ajouter_vue(uuid) to anon, authenticated;

-- Codes d'abonnement (invisibles pour le public)
create table if not exists public.codes (
  code text primary key,
  jours integer not null default 30,
  utilise boolean not null default false,
  utilise_le timestamptz,
  created_at timestamptz not null default now()
);
alter table public.codes enable row level security;

create or replace function public.activer_code(c text) returns integer
language plpgsql security definer set search_path = public as $$
declare j integer;
begin
  update public.codes set utilise = true, utilise_le = now()
  where code = upper(trim(c)) and utilise = false
  returning jours into j;
  return j;
end $$;
grant execute on function public.activer_code(text) to anon, authenticated;

-- ------------------------------------------------------------
-- UTILISATION AU QUOTIDIEN (dans SQL Editor)
--
-- Valider une publication :
--   update public.posts set approved = true where id = 'ID_DE_LA_PUBLICATION';
-- Valider toutes les publications en attente :
--   update public.posts set approved = true where approved = false;
-- Créer des codes d'abonnement (30 jours) après un paiement reçu :
--   insert into public.codes (code, jours) values ('XACE-AB12CD', 30);
-- Voir vos gains de pub (à 100 $ pour 1000 vues, à modifier selon vos accords) :
--   select titre, vues, round(vues / 1000.0 * 100, 2) as gain_usd
--   from public.posts order by vues desc;
-- ------------------------------------------------------------
