class CarbonQuery
  def self.total_intersection_area(the_geom, table_name, srid)
      <<-SQL
      SELECT SUM(area) as area FROM
        (SELECT ST_AREA(ST_Transform(ST_SetSRID(ST_INTERSECTION(b.the_geom, a.the_geom), 4326),#{srid}))/10000 as area
        FROM #{table_name} a
        INNER JOIN
          (SELECT
            ST_SetSRID(
              #{the_geom}
            , 4326)
            as the_geom
          ) b
        ON ST_Intersects(a.the_geom, b.the_geom)) c;
      SQL
  end
end
