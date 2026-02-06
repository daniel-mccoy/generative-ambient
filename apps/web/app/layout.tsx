import type { Metadata } from "next";
import Link from "next/link";
import "./globals.css";

export const metadata: Metadata = {
  title: "Generative Ambient",
  description:
    "Never-repeating ambient music paired with reactive visuals for meditation, focus, sleep, and spa environments.",
};

export default function RootLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <html lang="en">
      <body className="min-h-screen bg-neutral-950 text-neutral-100 antialiased">
        <nav className="flex items-center gap-6 border-b border-neutral-800 px-6 py-4">
          <Link href="/" className="text-lg font-semibold tracking-tight">
            Generative Ambient
          </Link>
          <Link href="/browse" className="text-sm text-neutral-400 hover:text-neutral-100">
            Browse
          </Link>
          <Link href="/create" className="text-sm text-neutral-400 hover:text-neutral-100">
            Create
          </Link>
          <Link href="/account" className="ml-auto text-sm text-neutral-400 hover:text-neutral-100">
            Account
          </Link>
        </nav>
        <main>{children}</main>
      </body>
    </html>
  );
}
