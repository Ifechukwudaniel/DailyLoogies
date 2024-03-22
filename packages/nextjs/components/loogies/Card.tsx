import React, { useState } from "react";
import Image from "next/image";

type CardProps = {
  index: string;
  imageUrl: string;
  name: string;
};

export const Card: React.FC<CardProps> = ({ imageUrl, index, name }) => {
  const [error, setError] = useState(false);

  return (
    <div key={index} className="border border-black rounded flex flex-col justify-between min-w-[14rem]">
      <div>
        <div className="py-1 min-h-[250px] w-full relative rounded-t border-b border-black flex items-center justify-center">
          <Image
            src={!error ? imageUrl : "/img/card-img.png"}
            alt={name + " image"}
            width={300}
            height={300}
            className="rounded-t  object-cover"
            onError={() => setError(true)}
          />
        </div>
        <div className="p-6 py-3 bg-base-100 ">
          <h2 className="font-semibold text-2xl">{name}</h2>
          <p className="">This Loogie is the color #f1c55f with a chubbiness of 60 and mouth length of 187!!!</p>
        </div>
      </div>
    </div>
  );
};
