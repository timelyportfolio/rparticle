import { reactWidget } from 'reactR';
import ParticleImage, { ParticleOptions, forces, ParticleForce } from "react-particle-image";

window.forces = forces

reactWidget(
  'rparticle',
  'output',
  {
    ParticleImage: ParticleImage
  },
  {}
);
