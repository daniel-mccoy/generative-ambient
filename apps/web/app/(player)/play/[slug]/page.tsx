export default async function PlayerPage({
  params,
}: {
  params: Promise<{ slug: string }>;
}) {
  const { slug } = await params;

  return (
    <div className="flex h-full items-center justify-center">
      <p className="text-neutral-500">
        Player: <span className="text-neutral-300">{slug}</span>
      </p>
    </div>
  );
}
