import { compile, prove, verify } from 'nargo';
import { writeFileSync } from 'fs';

(async () => {
  await compile();
  const input = 12345;
  const hash = poseidon([input]);

  const proof = await prove('main', { input, hash });
  writeFileSync('./proof.json', JSON.stringify({ proof, hash }));
})();