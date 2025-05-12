import React, { useCallback, useState } from "react";
import { useWalletKit } from "@mysten/wallet-kit";
import { TransactionBlock } from "@mysten/sui.js/transactions";
import { SuiClient } from "@mysten/sui.js/client";
import { toast } from "sonner";

const client = new SuiClient({ url: "https://fullnode.testnet.sui.io" });

export default function Vault() {
  const { currentAccount, signAndExecuteTransactionBlock } = useWalletKit();
  const [loading, setLoading] = useState(false);

  const handleUnlock = useCallback(async () => {
    if (!currentAccount) return toast.error("Connect wallet first");
    setLoading(true);

    try {
      const pubJson = await import("../../circuit/public.json");
      const pubBigInt = BigInt(pubJson[0]).toString(16).padStart(64, "0");
      const pubBytes = pubBigInt.match(/.{1,2}/g)!.map((b) => parseInt(b, 16));

      const tx = new TransactionBlock();
      tx.moveCall({
        target: "zk_safe::vault::unlock",
        arguments: [
          tx.object("<VAULT_ID_HERE>"),
          tx.pure(pubBytes, "vector<u8>")
        ],
      });

      const result = await signAndExecuteTransactionBlock({
        transactionBlock: tx,
        chain: "sui:testnet",
      });

      toast.success("Vault unlocked!");
      console.log("TX result:", result);
    } catch (err) {
      console.error(err);
      toast.error("Unlock failed");
    } finally {
      setLoading(false);
    }
  }, [currentAccount]);

  return (
    <div className="p-6 max-w-md mx-auto bg-white rounded-xl shadow space-y-4">
      <h2 className="text-xl font-bold">ZK Vault Unlock</h2>
      <button
        onClick={handleUnlock}
        disabled={loading}
        className="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 disabled:opacity-50"
      >
        {loading ? "Unlocking..." : "Unlock Vault"}
      </button>
    </div>
  );
}
